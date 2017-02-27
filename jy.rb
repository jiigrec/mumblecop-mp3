
# MP3 streamer for mumblecop
# by Jean-Yves Roda - https://jeanyves.pro/

require 'uri'


class MP3Player < Plugin
  def initialize
    super
    @needs_sanitization = true
    @commands = %w(mp3)
    @help_text = 'Play a mp3 file from URL'
    @min_args = 1
  end

  def go(source, _command, args, bot)
    bot.mpd.add(args[0].to_s)
    bot.mpd.play if bot.mpd.stopped?
	songname = args[0].to_s
	begin
		songname = URI.decode(songname)
	end while(songname != URI.decode(songname) )
	begin
		songname = songname.partition("/").last
	end while (songname != songname.partition("/").last )
    bot.say(self, source, 'Request successful. Loading  ', songname, ' ...')
  rescue => e
    bot.say(self, source, 'Failed to stream song. Check given url')
    bot.say(self, source, e.message)
  end
end