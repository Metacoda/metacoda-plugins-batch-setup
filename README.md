# Metacoda Plug-ins Batch Interface Setup Utility

# Intro

This repository provides a utility to help Metacoda customers and partners setup and use the
Batch Interface for [Metacoda® Security Plug-ins](https://www.metacoda.com/en/products/security-plug-ins/)
with [SAS®](https://www.sas.com/) software.

The Metacoda Plug-ins Batch Interface is used to automate and schedule activities that you might
otherwise do manually using Metacoda Plug-ins inside SAS Management Console. This can include:
* Exporting HTML reports to document a SAS metadata security implementation (ACTs, ACEs, Users, 
  Groups, Roles, Capabilities, Protected Objects, Logins, Internal Logins, Authentication Domains,
  External Identities)
* Exporting simple CSV files for ACTs, ACEs, Users, Groups, Roles, Capabilities etc.
* Exporting Metadata Security Test XML files to use for subsequent security testing
* Running SAS metadata security implementation, effective permission, and recommended practice
  tests using the [Metacoda Security Testing Framework](https://www.metacoda.com/en/products/security-plug-ins/testing-framework/)
* Populating SAS metadata users, groups, and roles by synchronizing with Microsoft Active Directory
  using the [Metacoda Identity Sync Plug-in](https://www.metacoda.com/en/products/security-plug-ins/identity-sync/)

This utility provides an [Apache Ant](https://ant.apache.org/) driven setup script to generate
site-specific sample scripts that you can use as-is, or as the basis for further customization.
You modify some properties files to supply some site and environment specific information, such as
SAS metadata server connection details and SMTP server details. The setup script uses those
properties files to create tailored copies of the batch interface samples for your SAS environment.
Those generated site-specific sample scripts can be moved elsewhere, if required, as they have no
further dependency on this setup utility. This means, for example, you can download and run the
setup utility on an internet connected machine, and then move the generated scripts onto servers
that may have no, or limited, internet connectivity.    

# Usage

You will need to run this Metacoda Plug-ins Batch Interface Setup Utility on a machine where
SAS Management Console has been installed, ideally one with access to the internet.
If the machine does not have access to the internet then you can also manually download any
required files yourself and place them into the site/downloads directory.
In the notes below you will see where any manual downloads may be required.
 
The site/environment directory structure that is generated by this utility can either be used
as-is, or moved onto a different target server where you want to run it.
Once generated, the site/environment directory structure is completely stand-alone requiring
only a Java Runtime Environment (JRE) to run it.

You can use the generated Metacoda Plug-ins Batch Interface scripts on any machine you like,
including the SAS Metadata Server, SAS Mid Tier server, SAS administrator workstation,
or even (rarely) a machine that has no SAS software installed.
We usually recommend running it on a SAS Mid-Tier server so that the batch scripts can be
scheduled, and any generated HTML reports made accessible via the SAS Web Server.

## Getting Started

To get started, log onto the machine where you want to run the setup script and clone this
repository:

```bash
ssh sas@sas94m5srv
cd /opt/sas94m6
git clone https://github.com/Metacoda/metacoda-plugins-batch-setup.git
\# ... or: git clone git@github.com:Metacoda/metacoda-plugins-batch-setup.git
```

Run the setup script without any parameters and it will print some environment info and
some help (use setup.bat on Windows platforms).

```bash
cd /opt/sas94m6/metacoda-plugins-batch-setup
./setup.sh
```

It will automatically use the system/configured Java Runtime Environment (JRE), so if you want
to force the use of a specific JRE then set JAVA_HOME first e.g.

```bash
export JAVA_HOME=/opt/sas94m6/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre
./setup.sh
```

To create customized batch scripts for a SAS environment use the **create-env** action/target:

```bash
./setup.sh create-env
```

## Configuration Properties

The first time you use create-env it will create the following files from templates:

* site/global.properties
* site/env-default.properties

... and then abort to allow you to make some required changes.
 
You can edit one, or both, of the properties files to supply details for your site and
SAS environment, and then run the same command again. If you are only configuring it to
work with a single SAS environment then you can put all of your settings in the
global.properties file.
You only need to use the env properties file if you are building for multiple
SAS environments (see below for more info).
 
When editing global.properties, at a minimum, you will need to provide:
* SAS Home directory location
* SAS Private Java Runtime Environment (JRE) directory location
* SAS Versioned Jar Repository (VJR) directory location
* SAS Management Console directory location
* SAS Metadata Server host name, port number, and logon details

You may also want to provide SMTP server details if you want the batch interface to
be able to send email alerts. See the comments in global.properties for more info.

These are the core settings you will need to review (from a newly created global.properties):

```
site.global.sashome=/opt/sas94
site.global.jrehome=${site.global.sashome}/SASPrivateJavaRuntimeEnvironment/9.4/jre
site.global.vjrhome=${site.global.sashome}/SASVersionedJarRepository
site.global.mchome=${site.global.sashome}/SASManagementConsole/9.4
site.global.meta.host=localhost
site.global.meta.port=8561
site.global.meta.user=sasadm@saspw
site.global.meta.pass={sas002}ThePwEncodedPassword
```

You will probably need to change site.global.sashome, site.global.meta.host
and, of course, site.global.meta.pass

## Metacoda Plug-ins JAR and License

Metacoda Plug-ins software itself is not included in this repository and so you will need to log
into support.metacoda.com and download metacoda.plugins.jar placing it in the site/downloads
directory.
 
At the same time save a copy of your metacoda-plugins-v6.lic license file in the site/downloads
directory too. This is the license file provided to you by Metacoda when you requested an 
evaluation or commercial license.

## SAS VJRExtract Utility

The setup script will also automatically download a required SAS VJRExtract utility from
support.sas.com, save it in the site/downloads directory, and unpack it into the
site/VJRExtract directory.
This VJRExtract utility is used to extract the pre-requisite SAS JAR files needed to run
the Metacoda Plug-ins Batch Interface with your SAS platform installation.

If you are running this setup script on a machine without internet access then you will need
to manually download the SAS VJRExtract utility from support.sas.com and save it in the
site/downloads directory.
 
You can download VJRExtract from
[SAS Usage Note 39911: Copying JAR files from the SAS Versioned Jar Repository to a directory](http://support.sas.com/kb/39/911.html) 

On the Downloads tab, click the **vjrextract.zip** link and save the file as
**fusion_39911_1_vjrextract.zip** in the site/downloads directory (which was created the
first time you ran setup.sh above).

## Building Metacoda Plug-ins Batch Interface Scripts

Once you have the Metacoda Plug-ins JAR and license downloaded (as well as the SAS VJRExtract
utility on a machine with no internet access), and updated global.properties with the 
details of your SAS environment, you can re-run the **create-env** action/target: 

```bash
./setup.sh create-env
```

If all goes well, and you see no errors, then you will have a directory tree of tailored
script and configuration files for the Metacoda Plug-ins Batch interface in the directory
site/env-default (or another name if you specified an environment name on the command line).

This generated site/env-default can then be moved onto the target server if you are not
running this setup script on the target server machine itself.  

## Running Metacoda Plug-ins Batch Interface Scripts

Once you have your site/env-default generated you can run all of the following sample scripts
(none of which make any changes to SAS metadata):

```bash
cd /opt/sas94m6/metacoda-plugins-batch-setup/site/env-default
./run-batch-export-html.sh 
./run-batch-export-sectest.sh
./run-batch-sectest.sh
```

... or if you built for a Windows environment:

```bash
run-batch-export-html.bat 
run-batch-export-sectest.bat
run-batch-sectest.bat
```

The run-batch-export-html.sh/bat script generates a series of SAS Metadata Security HTML reports
under the **site/env-default/output/html** directory.  

The run-batch-export-sectest.sh/bat script exports a series of Metadata Security Test XML files 
in the **site/env-default/output/sectest** directory. These XML files can be used for 
subsequent metadata security implementation testing of that SAS environment (or others).
You may also decide to take those test XML files and edit them for more targeted testing.   

The run-batch-sectest.sh/bat script will run a series of sample implementation and recommended
practice Metadata Security Test XML files against the SAS environments. The test results will
be written to the **site/env-default/output/sectest-results** directory.
You should expect many test failures from these sample tests as the implementation tests may
not match your SAS environment, you may not be following all of the recommended practices,
and may need to configure additional test exclusions. However, these sample tests can be
used as the basis for further customization to meet your own implementation and recommended
practice metadata security test regime.
 
## Working with Multiple SAS Environments 

This Metacoda Plug-ins Batch Interface Setup Utility can also be used to create customized batch
scripts for multiple SAS environments and so configuration information is split over a global
properties file and one or more environment properties files.
Each environment can have a name (e.g. lev1, lev2, etc) and if you don't specify a name
(as above) it will use the name 'default'.

If you want to build for multiple environments then run the script multiple times,
specifying a different environment name for each e.g. 

```bash
./setup.sh create-env -Dsite.env=lev1
./setup.sh create-env -Dsite.env=lev2
```

... this will create initial properties files (from templates):
 
* site/global.properties
* site/env-lev1.properties
* site/env-lev2.properties

... and then later generate customized batch configurations in the directories:

* site/env-lev1
* site/env-lev2

You can put any cross-environment settings, that are the same across all environments,
in the global.properties and any environment-specific details in the env level properties
files.

# Uninstall

To uninstall, simply delete the directory into which you cloned this repository, remembering
to backup any configuration files or scripts that you may need later.

This utility does not install any files outside of the directory into which you cloned this
repository so there is nothing else to uninstall, other than any copies you may have manually
made yourself.
 
# Resources

You may find the following resources useful when reviewing this documentation and samples:

* [Metacoda Security Plug-ins Product Page](https://www.metacoda.com/en/products/security-plug-ins/)
* [Metacoda Security Testing Framework Product Page](https://www.metacoda.com/en/products/security-plug-ins/testing-framework/)
* [Metacoda Plug-ins Customer Documentation](https://support.metacoda.com/docs/plugins/v6.1/) (requires login)

# License

The setup scripts and samples contained in this repository are licensed under the terms of the
[Apache License 2.0](https://opensource.org/licenses/Apache-2.0).
See [LICENSE.txt](LICENSE.txt) for more information.

Metacoda Plug-ins, as required to run any batch scripts generated using this utility, is a commercial
product from Metacoda, and must be separately licensed and obtained from Metacoda.

# Trademarks

Metacoda® and all other Metacoda product or service names are registered trademarks or trademarks of
[Metacoda Group Pty Ltd](https://www.metacoda.com/) in the USA and other countries.

SAS® and all other SAS Institute Inc. product or service names are registered trademarks or
trademarks of [SAS Institute Inc.](https://www.sas.com/) in the USA and other countries. ® indicates
USA registration.

Other product and company names mentioned herein may be registered trademarks or trademarks of
their respective owners.