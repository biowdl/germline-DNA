# Copyright (c) 2018 Leiden University Medical Center
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import subprocess
from typing import Dict, Generator, Union
import tempfile
from pathlib import Path

import pytest

TEST_DATA = Path(Path(__file__).parent, "data")


def create_sdf(sequence_path: Path) -> Path:
    # We need a not yet existing directory. Hence mktemp. (Even though this
    # is unsafe as another tempfile process may claim the directory in theory.)
    output_sdf = tempfile.mktemp()
    args = ["rtg", "format", "-o", output_sdf, str(sequence_path)]
    subprocess.run(args, check=True)
    return Path(output_sdf)


@pytest.mark.workflow("Germline_GenderAware")
def test_variants_gender_aware_male(workflow_dir: Path):
    summary = get_rtg_summary(workflow_dir, "male")
    # The end of the PAR region is marked as a mutation of X on males.
    assert summary["False-pos"] == 1
    assert summary["False-neg"] == 0


@pytest.mark.workflow("Germline_GenderAware")
def test_variants_gender_aware_female(workflow_dir: Path):
    summary = get_rtg_summary(workflow_dir, "female")
    assert summary["False-pos"] == 0
    assert summary["False-neg"] == 0


def get_rtg_summary(workflow_dir: Path, sample: str
                    ) -> Dict[str, Union[float, int]]:
    baseline_vcf_file = Path(TEST_DATA, "gender-aware", "expected.vcf.gz")
    calls_vcf_file = Path(workflow_dir, "test-output", "out", "multisample.vcf.gz")
    reference_fasta = Path(TEST_DATA, "gender-aware", "reference.fasta")
    sdf_path = create_sdf(reference_fasta)
    # We need a not yet existing directory. Hence mktemp. (Even though this
    # is unsafe as another tempfile process may claim the directory in theory.)
    output_dir = Path(tempfile.mktemp())
    args = ["rtg", "vcfeval",
            "-b", str(baseline_vcf_file),
            "-c", str(calls_vcf_file),
            "-t", str(sdf_path),
            "-o", str(output_dir),
            "--sample", sample]
    subprocess.run(args, check=True, stdout=subprocess.PIPE)
    summary_file = Path(output_dir, "summary.txt")
    summary_dict_generator = rtg_summary_to_dict_generator(summary_file)
    summary = next(summary_dict_generator)
    return summary


def rtg_summary_to_dict_generator(
        summary_file: Path) -> Generator[
            Dict[str, Union[float, int]], None, None]:
    with summary_file.open("rt") as summary_h:
        headers = summary_h.readline().strip().split()
        summary_h.readline()
        for line in summary_h:
            values = line.strip().split()
            summary_dict = {}  # Dict[str, Union[float, int]]
            for header, value in zip(headers, values):
                if value == "None":
                    # Sometimes happens in the threshold column.
                    # Use 0.0 instead of None for consistency.
                    summary_dict[header] = 0.0
                elif "." in value:
                    # Some columns have floats
                    summary_dict[header] = float(value)
                else:
                    summary_dict[header] = int(value)
            yield summary_dict
