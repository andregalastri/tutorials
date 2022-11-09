#!/bin/bash
screenWidth=$(xdpyinfo | grep dimensions | awk '{print $2}' | awk -Fx '{print $1}')
screenHeight=$(xdpyinfo | grep dimensions | awk '{print $2}' | awk -Fx '{print $2}')
marginLeft=8
marginRight=8
marginTop=$((32+10))
marginBottom=8
gap=8

activeWidth=$(($screenWidth-$marginLeft-$marginRight))
activeHeight=$(($screenHeight-$marginTop-$marginBottom))

gridSizeX=$(($activeWidth/4))
gridSizeY=$(($activeHeight/2))

eval $(xwininfo -id $(xdotool getactivewindow) |
    sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/windowX=\1/p" \
           -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/windowY=\1/p" \
           -e "s/^ \+Width: \+\([0-9]\+\).*/windowWidth=\1/p" \
           -e "s/^ \+Height: \+\([0-9]\+\).*/windowHeight=\1/p" )

moveX=$windowX
moveY=$windowY
resizeX=$windowWidth

echo $moveX

moveRight=$(($windowX+$gridSizeX))
moveLeft=$(($windowX-$gridSizeX))
moveUp=$(($windowY-$gridSizeY))
moveDown=$(($windowY+$gridSizeY))

growRight=$(($windowWidth+$gridSizeX))
shrinkLeft=$(($windowWidth-$gridSizeX))


checkMoveX(){
    if (( $(($moveRight+$windowWidth-$marginLeft-$marginRight)) > $(($activeWidth)) )); then
        echo "STOP"
    else
        echo "KEEP"
    fi
}

case "$1" in
    ("move")
    case "$2" in
        ("right")
            if (( $(($moveRight+$windowWidth-$marginLeft-$marginRight)) < $(($activeWidth)) )); then
                moveX=$moveRight
            fi
        ;;
        ("left")
            if (( $(($moveLeft+$windowWidth-$marginLeft-$marginRight)) > $(($marginLeft)) )); then
                moveX=$moveLeft
            fi
        ;;
        ("up")
            if (( $(($moveUp+$windowHeight-$marginTop-$marginBottom)) > $(($marginTop)) )); then
                moveY=$moveUp
            fi
        ;;
        ("down")
            if (( $(($moveDown+$windowHeight-$marginTop-$marginBottom)) > $(($activeHeight)) )); then
                moveY=$moveDown
            fi
        ;;
    esac
    ;;
    ("resize")
    case "$2" in
        ("right")
            if (( $(($windowWidth)) < $(($activeWidth)) )); then
                resizeX=$growRight
            fi
        ;;
        ("left")
            if (( $(($windowWidth)) > $(($gridSizeX)) )); then
                resizeX=$shrinkLeft
            fi
        ;;
    esac
    ;;
    (*) echo "invalid" ;;
esac


# if [ $1 == "right" ]; then
#     echo "Parametro 1 ($1) é igual a 2 ($2)."
# else
#     echo "Parametro 1 ($1) não é igual a 2 ($2)."
# fi
wmctrl -r :ACTIVE: -e 0,$moveX,$moveY,$resizeX,$gridSizeY