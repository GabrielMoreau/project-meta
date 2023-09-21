# SoftWare / ProjectMeta - Meta project for Open Data management

## Aim

Project-Meta is a software to help you to manage your open data, using the protocol OPeNDAP (DAP).
The initiative is supported by the European Commission as part of the project Hydralab+ of the Horizon 2020 programme.
This programme  requests that research data are open access, that is providing online access free of charge to the end-user and reusable.
Furthermore access must allow the right to copy, distribute, search, link, crawl and mine the data.
In addition to these general requests, we aim at achieving the following goals:

 1. Allow the end user to scan and visualise the data without downloading.
 1. Integrate the process in the data analysis procedure, with minimal additional work.

This [document](doc/OpenDAP_GM.pdf) describes the wider motivation of the project. 


## OPeNDAP

The protocol OPeNDAP (Open-source Project for a Network Data Access Protocol).
This includes standards for encapsulating structured data, annotating the data with attributes and adding semantics that describe the data.
OPeNDAP is widely used by governmental agencies such as NASA and NOAA to serve satellite, weather and other observed earth science data.

The protocol is based on http, so that data can be scanned with an ordinary web browser.
However added functionality of data visualization is provided by graphics programs (like Matlab, GrADS, Ferret or ncBrowse).
Compared to ordinary file transfer protocols (e.g. FTP) a major advantage using OPeNDAP is the ability to retrieve subsets of files, so it is possible to work remotely without downloading whole data files.
Although any file format can be use, data are often in HDF or NetCDF formats.
The older NetCDF format is limited to arrays of numbers, while HDF provides wider possibilities of data structures (and it contains NetCDF as a particular case).
We choose the NetCDF format which is sufficient for most experimental data and can be more easily read with a variety of software.


## Description

The creation of the OpenDAP repository is done
by the script [project-meta](https://legi.gricad-pages.univ-grenoble-alpes.fr/soft/trokata/project-meta/)
using UNIX commands, scripts in Perl and C++.

The first step is to make a list of the data folders to display.
This list needs to be introduced in a text file,
complemented by some information about the authors of the work and about related publications.
This text file must be put in your current folder with the name `PROJECT-META.yml`.
The text structure must follow some simple rules consisting in the YAML format.
An example could be found in the Project-Meta repository or online
[PROJECT-META.sample.yml](https://legi.gricad-pages.univ-grenoble-alpes.fr/soft/trokata/project-meta/PROJECT-META.sample.yml).
```bash
project-meta help
man project-meta
```


## `PROJECT-META.yml` meta file

This file is at the core of the procedure.
A first task is to list the data folder to publish.
For that purpose a good practice is to organise the data and the procedures of analysis
such that the final data to publish are contained in folders named with specific extensions.
Then search tools can be used to list all the selected folders.
For instance the following unix command lists all the folders with extension `*.mproj*`
and append it to the file `PROJECT-META.yml` (and creates the file if it does not exist yet):
```bash
find . -name '*.mproj*' -a -type d | sed 's/^/    - /;' >> PROJECT-META.yml
```
The `find` command only search the folders with the right extension (recursively)  under the current one (.)
and the `sed` command add 4 spaces and the dash at the beginning of each line in order to respect the YAML format.

The YAML file has to be complemented by general information about the authors and the related publications,
following the template [PROJECT-META.sample.yml](https://legi.gricad-pages.univ-grenoble-alpes.fr/soft/trokata/project-meta/PROJECT-META.sample.yml).


## Debian package

Debian is a GNU/Linux distribution.
**Debian** (and certainly Ubuntu) **package** for all arch (`project-meta` is written is a script language) could be downloaded on: https://legi.gricad-pages.univ-grenoble-alpes.fr/soft/trokata/project-meta/download.

You can then install it with

```bash
sudo dpkg -i project-meta_*_all.deb
```
(just replace * with the version you have downloaded).


## Software repository

All code is under **free license**.
Scripts in Bash are under GPL version 3 or later (http://www.gnu.org/licenses/gpl.html),
C++ sources are under GPL version 2 or newer,
the Perl scripts are under the same license as Perl itself ie the double license GPL and Artistic License (http://dev.perl.org/licenses/artistic.html).

All sources are available on the campus forge: https://gricad-gitlab.univ-grenoble-alpes.fr/legi/soft/trokata/project-meta.git

The sources are managed via Git (GitLab).
It is very easy to stay synchronized with these sources

 * initial recovery
   ```bash
   git clone https://gricad-gitlab.univ-grenoble-alpes.fr/legi/soft/trokata/project-meta.git
   ```
 * the updates thereafter
   ```bash
   git pull
   ```

It is possible to have access to writing at the forge on reasoned request to [Gabriel Moreau](mailto:Gabriel.Moreau(A)legi.grenoble-inp.fr).
For issues of administration time and security, the forge is not writable without permission.
For the issues of decentralization of the web, autonomy and non-allegiance to the ambient (and North American) centralism, we use our own forge...

You can propose an email patch of a particular file via the `diff` command.
Note that the use of the unified format with the `-u` option.
Two examples:
```bash
diff -u project-meta.org project-meta.new > project-meta.patch
```
We apply the patch (after having read and read it again) via the command
```bash
patch -p0 < project-meta.patch
```
