This file specifies the dependencies
and nessesary structure of the project directory
for the script to work propperl.


DIRECTORY STRUCTURE:
As of now the script supports 5 languages js/ts/C/python/bash
for currect preformance there must be a directiory containing subdirectories
under the name of each language (c must be written in lower-case).
in ts and js directiories there must be 2 subdirectories named react and
js/ts-projects. the script navigates to those directories
The structure is as follows:


   ----------------
   |   rootDir    |
   ----------------
   |  \  \   \     \
   |   \  \   \     \
   js   c bash \     \
  /  \         pyhton \
 /    \                \
react  js-projects      \
                        ts
                        /\
                       /  \
                      /    \
                  react  js-projects

DEPENDENCIES:
1.hub (githubt special utility to initialize and manage github repos from terminal)
2.npm + npx
3.node
4.lastest bash version
5.pyhton3





