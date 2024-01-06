function docker_in
  docker exec -it $argv bash
end

function cd
    if count $argv > /dev/null
        builtin cd "$argv"; and ls
    else
        builtin cd ~; and ls
    end
end

function open
    switch (uname)
    case Linux

        for file in $argv
		    xdg-open $file
	    end 1> /dev/null 2> /dev/null
    case Darwin

        command open $argv
    end
end

# Change directory with Ctrl+Left/Right (backward and forward on latest history)
function cd_undo
	pushd .. > /dev/null 2>&1
    commandline -f repaint
end

function cd_redo
    string match -q "*$PWD*" $dirstack[1]; and popd > /dev/null 2>&1
    commandline -f repaint
end