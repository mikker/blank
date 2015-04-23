# Turns out ...

When you set Safari to "Open Blank Page" on new tab, it does this automatically. I had just set my homepage to `about:blank` which obviously isn't the same. Well. I'll keep this around for showing the concept but you really should just use "Open Blank Page".

# blank

Oh, where do I even start.

Now and then I like to sport a completely stripped down Safari, hiding the toolbar and everything else:

![Stripfari](http://s3.brnbw.com/Screen-Shot-2015-04-17-10-52-27.png)

Look at that! _Just_ the content. Just me and my one million tabs. Only problem: when I make a new tab the address bar isn't focused, as it is when the toolbar is visible. So you need to press `cmd + l` yourself like an animal.

So we make a start-page for new tabs. But there's no browser-api for focusing the browser chrome. But there _is_ AppleScript (there's always AppleScript).

We'll just make a tiny server that serves a page with one button that it clicks itself. And then make that button call some Applescript. That's definitely not an insane solution to a very serious _problem_.

# Install

1. Clone this somewhere
1. `rake install`

Thanks to [dotjs](https://github.com/defunkt/dotjs) for the installation Rakefile.

# Upgrade

1. `$ rake uninstall && rake install`

