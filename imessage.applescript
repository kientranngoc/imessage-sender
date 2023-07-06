#!/usr/bin/osascript
-- another way of waiting until an app is running
on waitUntilRunning(appname, delaytime)
    repeat until my appIsRunning(appname)
        tell application "Messages" to close window 1
        delay delaytime
    end repeat

    -- the fact that Messages.app is running
    -- does not mean it is ready to send,
    -- unfortunately, add another small delay
    delay delaytime
end waitUntilRunning

on appIsRunning(appName)
    application appname is running
end appIsRunning

-- use system events (unused)
on SysevAppIsRunning(appName)
    tell application "System Events" to (name of processes) contains appName
end SysevAppIsRunning

-- use finder (unusged)
on finderAppIsRunning(appName)
    tell application "Finder" to (name of every process) contains appName
end finderAppIsRunning

--
-- An AppleScript function that reads a file and returns the lines
-- from that file as a list.
--
on returnFileContentsAsList {theFile}
  set fileHandle to open for access theFile
  set theLines to paragraphs of (read fileHandle as «class utf8»)
  close access fileHandle
  return theLines
end returnFileContentsAsList

-- taken from:
-- http://stackoverflow.com/questions/11812184/how-to-send-an-imessage-text-with-applescript-only-in-provided-service
-- thanks to users @Senseful and @DigiLord
on run {targetBuddyPhone}
    set currentPath to (((path to me as text) & "::") as alias) as string
    set messages to returnFileContentsAsList(currentPath & "messages.txt")
    set randomMessage to some item of messages
    tell application "Messages"
        -- if Messages.app was not running, launch it
        set wasRunning to true
        if it is not running then
            set wasRunning to false
            launch
            close window 1
            my waitUntilRunning("Messages", 1)
            close window 1
        end if

        -- send the message
        set targetService to 1st service whose service type = iMessage
        set targetBuddy to buddy targetBuddyPhone of targetService
        send randomMessage to targetBuddy

        -- if the app was not running, close the window
        if not wasRunning
            close window 1
        end if
    end tell
end run
