#!/usr/bin/env zsh

preprocess_configs() {
    local CONF_FILE
    find -name '*.j2' | while IFS=$'\n' read CONF_FILE; do
        make -s -f jinja.make ARGS="$@" ${CONF_FILE%.j2}
    done
}

clean_configs() {
    local CONF_FILE
    find -name '*.j2' | while IFS=$'\n' read CONF_FILE; do
        ./preprocess.py "$@" --clean $CONF_FILE ${CONF_FILE%.j2}
    done
}


while getopts "nsc" ARG; do
    case "$ARG" in
        n)
            DRYRUN="-n"
            ;;
        s)
            git submodule update --init
            ;;
        c)
            clean_configs -v
            exit
            ;;
        ?)
            ;;
    esac
done
shift $[$OPTIND-1]

preprocess_configs -v


if [ $# = 0 ]; then
    PACKAGES=(topdir/*(:t))
else
    PACKAGES=$argv
fi

stow $DRYRUN -v -t $HOME -d topdir --no-folding -S ${=PACKAGES}
