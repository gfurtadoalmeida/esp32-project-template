$ProjectFolder = $PSScriptRoot
$EspIdfDockerImage = 'gfurtadoalmeida/esp32-docker-sonar:v5.1'

switch ($args[0]) {
    'build' {
        &docker.exe run --rm --env LC_ALL='C.UTF-8' -v ${ProjectFolder}:/project -w /project ${EspIdfDockerImage} idf.py build
    }
    'build-test' {
        &docker.exe run --rm --env LC_ALL='C.UTF-8' -v ${ProjectFolder}:/project -w /project ${EspIdfDockerImage} idf.py build -C ./test
    }
    'clean' {
        &docker.exe run --rm --env LC_ALL='C.UTF-8' -v ${ProjectFolder}:/project -w /project ${EspIdfDockerImage} idf.py fullclean
    }
    'clean-test' {
        &docker.exe run --rm --env LC_ALL='C.UTF-8' -v ${ProjectFolder}:/project -w /project ${EspIdfDockerImage} idf.py fullclean -C ./test
    }
    Default {
        Write-Error "Command not recognized.`nValid commands:`n`t* build`n`t* build-test`n`t* clean`n`t* clean-test"
    }
}
