#!/bin/sh
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P02d3241
  \e]P1b14a56
  \e]P292b477
  \e]P3e6c274
  \e]P46d8eb5
  \e]P5a5789e
  \e]P675b3c7
  \e]P7dfe3ed
  \e]P83b4358
  \e]P9b14a56
  \e]PA92b477
  \e]PBe6c274
  \e]PC6d8eb5
  \e]PDa5789e
  \e]PE7cafad
  \e]PFe7ebf1
  "
  # get rid of artifacts
  clear
fi

test -r ".dir_colors" && eval $(dircolors .dir_colors)
