#! /usr/bin/bash

: '
    creates a new github project with git integration
'

#gettin golobal vriables from config file
projectName=""
languages=(js python c bash ts)
react=false

projectDirPath=$(<paths.config)
projectDirPath=$(echo "$projectDirPath" | grep projectDirPath)
projectDirPath=${projectDirPath#*=}

newGithubRepo=true
lang=0

githubURL=$(<paths.config)
githubURL=$(echo "$githubURL" | grep githubURL)
githubURL=${githubURL#*=}

templatePath=$(<paths.config)
templatePath=$(echo "$templatePath" | grep templatePath)
templatePath=${templatePath#*=}

githubProfile=$(<paths.config)
githubProfile=$(echo "$githubProfile" | grep githubProfile)
githubProfile=${githubProfile#*=}

startProject=(startJsProject startPythonProject startCProject startBashProject startTsProject)

function setReact {

    if (($1 == "1" || $1 == "5")); then
        react=true
        echo "is this a react project? (defaults to yes options: y/n/yes/no?)"
        read answer

        if [[ "${answer^^}" == "NO" || "${answer^^}" == "N" ]]; then
            react=false
        fi
    fi
}

function setGithub {

    echo "Do you want to create a new github repository for this project?
(defaults to yes options: y/n/yes/no)"
    read answer

    if [[ "${answer^^}" == "N" || "${answer^^}" == "NO" ]]; then
        newGithubRepo=false
    fi
}

function createNewGithubRepo {

    echo \
"Making a new github repository at
$githubURL/$githubProfile/$projectName"

    hub init
    hub create $projectName

}

function startJsProject {

    if ! $react ; then
        echo "inside the if"
        cp $templatePath/{index.html,index.css,index.js} ./
        python3 $templatePath/modify.py $projectDirPath index.html $projectName

        for file in index.*; do
            mv "$file" $projectName${file#index}
        done
        return
    fi

    mkdir server
    cd server && npm init -y && cp $templatePath/index.js ./server.js && cd ..
    npx create-react-app client
    cd client
    cd src
    mv App.js ${projectName^}.js
    mv App.css ${projectName^}.css
    mkdir components && cd ../..

}

function startTsProject {


    if [ $react != ture ]; then
        echo "inside the if"
        cp $templatePath/{index.html,index.css,index.js} ./
        python3 $templatePath/modify.py $projectDirPath index.html $projectName

        for file in index.*; do
            mv "$file" $projectName${file#index}
        done
        mv $projectName.js $projectName.ts
        return
    fi

    mkdir server
    cd server && npm init -y && cp $templatePath/index.js ./server.ts && cd ..
    npx create-react-app client --template typescript
    cd client
    cd src
    mv App.ts ${projectName^}.ts
    mv App.css ${projectName^}.css
    mkdir components && cd ../..

}

function startPythonProject {

    cp $templatePath/main.py ./$projectName.py
}

function startBashProject {
    cp $templatePath/script.sh ./
}

function startCProject {
    mkdir src input && cd input && touch input.txt && cd ../src
    cp $templatePath/makefile ./
    cp $templatePath/main.c ./$projectName.c
    python3 $templatePath/modify.py $projectDirPath/src makefile $projectName
    cd ..
}

until [[ $projectName != "" ]]; do
    echo "Please name your project:"
    read projectName
done

while true
do

    echo "what language?
    1.js
    2.python
    3.c
    4.bash
    5.ts"
    read lang

    if [[ "$lang" > "5" || "$lang" < "1" || $lang == "" ]]; then
        echo "no such language"
        continue

    else (("$lang" == "1" || "$lang" == "5"))
        setReact lang
        setGithub
        lang=$lang-1
        break
    fi
done


echo "name: $projectName
language: ${languages[$lang]}
react: $react
github: $newGithubRepo"


projectDirPath=$projectDirPath/${languages[lang]}

if [[ "${languages[lang]}" == "js" || "${languages[lang]}" == "ts" ]]; then
    if $react; then
        projectDirPath=$projectDirPath/react
    else
        projectDirPath=$projectDirPath/${languages[lang]}-projects
    fi
fi

cd $projectDirPath
mkdir $projectName
projectDirPath=$projectDirPath/$projectName
cd $projectName


${startProject[lang]}


if  $newGithubRepo ; then
    createNewGithubRepo $githubProfile $projectName
fi

















