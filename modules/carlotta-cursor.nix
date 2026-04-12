{ pkgs, ... }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "carlotta-cursor";
  version = "1.0";
  src = ../config/cursors/carlotta;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/carlotta-cursor
    cp -r . $out/share/icons/carlotta-cursor

    cd $out/share/icons/carlotta-cursor/cursors

    cp -f Normal left_ptr
    cp -f Normal arrow
    cp -f Normal default
    cp -f Normal top_left_arrow
    cp -f Normal left-arrow
    cp -f Normal pointer
    cp -f Normal hand1
    cp -f Normal hand2
    cp -f Normal up_arrow
    cp -f Normal down-arrow
    cp -f Normal right-arrow
    cp -f Normal circle
    cp -f Normal pirate

    cp -f Busy wait
    cp -f Busy watch
    cp -f Busy progress
    cp -f Busy left_ptr_watch
    cp -f Busy half-busy

    cp -f Link hand2
    cp -f Link hand
    cp -f Link pointing_hand
    cp -f Link hand1
    cp -f Link pointer

    cp -f Text xterm
    cp -f Text ibeam
    cp -f Text text

    cp -f Precision crosshair
    cp -f Precision cross
    cp -f Precision draft

    cp -f Help question_arrow
    cp -f Help whats_this
    cp -f Help left_ptr_help
    cp -f Help help

    cp -f Move fleur
    cp -f Move size_all
    cp -f Move move
    cp -f Move dnd-move
    cp -f Move dnd-none
    cp -f Move all-scroll

    cp -f Horizontal h_double_arrow
    cp -f Horizontal sb_h_double_arrow
    cp -f Horizontal size_hor
    cp -f Horizontal ew-resize
    cp -f Horizontal row-resize
    cp -f Horizontal e-resize
    cp -f Horizontal w-resize
    cp -f Horizontal left_side
    cp -f Horizontal right_side

    cp -f Vertical v_double_arrow
    cp -f Vertical sb_v_double_arrow
    cp -f Vertical size_ver
    cp -f Vertical n-resize
    cp -f Vertical s-resize
    cp -f Vertical ns-resize
    cp -f Vertical top_side
    cp -f Vertical bottom_side
    cp -f Vertical split_v

    cp -f Diagonal1 fd_double_arrow
    cp -f Diagonal1 size_fdiag
    cp -f Diagonal1 ne-resize
    cp -f Diagonal1 se-resize
    cp -f Diagonal1 nwse-resize
    cp -f Diagonal1 nesw-resize
    cp -f Diagonal1 top_left_corner
    cp -f Diagonal1 top_right_corner

    cp -f Diagonal2 bd_double_arrow
    cp -f Diagonal2 size_bdiag
    cp -f Diagonal2 nw-resize
    cp -f Diagonal2 sw-resize
    cp -f Diagonal2 nwse-resize
    cp -f Diagonal2 nesw-resize
    cp -f Diagonal2 bottom_left_corner
    cp -f Diagonal2 bottom_right_corner

    cp -f Unavailable not-allowed
    cp -f Unavailable crossed_circle
    cp -f Unavailable not_allowed
    cp -f Unavailable forbidden
    cp -f Unavailable dnd_no_drop
    cp -f Unavailable no_drop

    cp -f Person grabbing
    cp -f Person closedhand
    cp -f Person grab
    cp -f Person openhand

    cp -f Pin center_ptr

    cp -f Handwriting pencil

    cp -f Alternate right_ptr
    cp -f Alternate context_menu

    cat > $out/share/icons/carlotta-cursor/index.theme << 'EOF'
    [Icon Theme]
    Name=carlotta
    Comment=carlotta Anime Cursor Theme
    EOF

    runHook postInstall
  '';
}
