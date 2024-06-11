# kruez dotfiles
# Manual Installation
## iTerm2
* Install the iterm2 color themes and setup them up on the profiles

## Firefox
* Symlink over the userChrome.css into `%FIREFOX_PROFILE%/chrome/`

### Tree Style Tabs Custom CSS

```css
/* Show title of unread tabs with red and italic font */
:root.sidebar tab-item.unread .label-content {
  color: red !important;
  font-style: italic !important;
}

/* Add private browsing indicator per tab */
:root.sidebar tab-item.private-browsing tab-label:before {
  content: "🕶";
}

/* Change Tab Height */
tab-item {
  --tab-size: 30px !important;
}
tab-item  tab-item-substance {
  height: var(--tab-size);
}

/* Highlight Active Tab */
tab-item.active tab-item-substance {
  height: 35px !important;
}
tab-item.active .background {
  background-color: steelblue;
  box-shadow: inset 0 0 10px #F3E1BE;
  animation: pulsate 4s ease-out infinite;
}
@-webkit-keyframes pulsate {
    0%   { box-shadow: inset 0 0 0 #F3E1BE; }
    25%  { box-shadow: inset 0 0 5px #F3E1BE; }
    50%  { box-shadow: inset 0 0 10px #F3E1BE; }
    75%  { box-shadow: inset 0 0 5px #F3E1BE; }
    100% { box-shadow: inset 0 0 0 #F3E1BE; }
}
tab-item.active .label-content {
  font-weight: bold;
  font-size: 12px;
  text-shadow: 1px 1px black;
}
tab-item.active tab-twisty,
tab-item.active .label-content,
tab-item.active tab-counter {
  color: #fff;
}

/* Only show tab close button on hover */
#tabbar tab-item tab-item-substance:not(:hover) tab-closebox {
  display: none;
}
```
## jenv
While `jenv` will install via the Brew commons file, you'll need to make sure to run
some additional setup defined on the jenv homepage to have it properly set `JAVA_HOME.

## Resources
* [gruvbox themes](https://github.com/gruvbox-community/gruvbox-contrib/)

# Usage
Given all the customization and various utils installed, we can keep track of various new items here to help refresh my memory until they're ingrained.

## fzf - fuzzy finder
- `CTRL-T` - Search for files and directories with a given name
- `CTRL-R` - Search command history
- `ALT-C` - Search and `cd` into the directory

## ranger - file tree UI
- 'r' - open ranger


## Improved Utils
- `gping` - Graphical ping

# To Fix
- Initial run of install script gets hijacked when running the oh-my-zsh install
- brew install requires sudo
- homebrew/cask-fonts tap is deprecated
