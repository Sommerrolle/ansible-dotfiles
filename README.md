Just trying to keep my dotfiles in one place. Started with writing bash scripts to maintain the same state for my different machines but found [jwalton3141s project](https://github.com/jwalton3141/ansible-dotfiles) with ansible. I think its a much better solution.

![example
desktop](https://github.com/Sommerrolle/ansible-dotfiles/blob/main/pics/desktop.png?raw=true)

## What's provisioned?

* [Alacritty](https://github.com/alacritty/alacritty): marketed as "the fastest
  terminal emulator in existence".
* [i3-gaps](https://github.com/Airblader/i3): a popular fork of the
  [i3wm](https://i3wm.org/) tiling window manager.
* [Polybar](https://github.com/polybar/polybar): a tool for creating and
  configuring status bars.
* [Vim](https://www.vim.org/about.php): a highly configurable and customisable
  text editor.
* [Zsh](https://wiki.archlinux.org/index.php/zsh): a popular UNIX shell (made
  all the more popular by the
  [oh-my-zsh](https://github.com/ohmyzsh/ohmyzshproject) project).

## I want it

```sh
git clone git@github.com:jwalton3141/ansible-dotfiles.git \
  && cd ansible-dotfiles \
  && ./bin/setup.sh
```
