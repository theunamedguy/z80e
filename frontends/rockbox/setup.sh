#!/bin/sh
#
# This script will prepare your Rockbox source folder for z80e compilation.
#
SCRIPT_PATH="${0%/*}"
if [[ ("$0" != "$SCRIPT_PATH") && ("$SCRIPT_PATH" != "") ]]; then
    cd $SCRIPT_PATH
fi
function print_help
{
    echo "Usage: `basename $0` [options] directory"
    echo "Options:"
    echo " -h, --help Display this information"
    echo " -p, --path <directory> Use <directory> as your Rockbox source path"
}
ROCKBOX_DIR=""
# parse arguments
while [[ $# > 0 ]]
do
    case "$1" in
        -p|--path)
            shift
            ROCKBOX_DIR="$1"
            ;;
        -h|--help)
            print_help
            exit 0
            ;;
        *)
            ;;
    esac
    shift
done
if [[ "$ROCKBOX_DIR" == "" ]]; then
    echo "Error: Rockbox source folder not specified"
    print_help
    exit 1
fi
# stop script on error
set -e
echo "Copying z80e sources to $ROCKBOX_DIR/apps/plugins/z80e ..."
mkdir -p $ROCKBOX_DIR/apps/plugins/z80e
cp z80e.c SOURCES z80e.make $ROCKBOX_DIR/apps/plugins/z80e/
cp -R ../../libz80e $ROCKBOX_DIR/apps/plugins/z80e/
if [[ `tail $ROCKBOX_DIR/apps/plugins/SUBDIRS -n 1` != "z80e" ]]; then
    echo "Appending z80e to $ROCKBOX_DIR/apps/plugins/SUBDIRS ..."
    echo "z80e" >> $ROCKBOX_DIR/apps/plugins/SUBDIRS
fi
if [[ `tail $ROCKBOX_DIR/apps/plugins/CATEGORIES -n 1` != "z80e,apps" ]]; then
    echo "Appending z80e to $ROCKBOX_DIR/apps/plugins/CATEGORIES ..."
    echo "z80e,apps" >> $ROCKBOX_DIR/apps/plugins/CATEGORIES
fi
echo "Done."
