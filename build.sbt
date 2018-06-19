organization := "com.github.biopet"
organizationName := "Biowdl"
name := "germline-DNA"

biopetUrlName := "germline-DNA"

startYear := Some(2018)

biopetIsTool := false

concurrentRestrictions := Seq(
  Tags.limitAll(
    Option(System.getProperty("biowdl.threads")).map(_.toInt).getOrElse(1)),
  Tags.limit(Tags.Compile, java.lang.Runtime.getRuntime.availableProcessors())
)

developers += Developer(id = "ffinfo",
                        name = "Peter van 't Hof",
                        email = "pjrvanthof@gmail.com",
                        url = url("https://github.com/ffinfo"))

scalaVersion := "2.11.12"

libraryDependencies += "com.github.biopet" %% "biowdl-test-utils" % "0.1-SNAPSHOT" % Test changing ()
libraryDependencies += "com.github.biopet" %% "ngs-utils" % "0.4-SNAPSHOT" changing ()
