#  -*- coding: utf-8 -*-
#  decisions.rb
#  Author: William Woodruff
#  ------------------------
#  A Cinch plugin that provides decisions for yossarian-bot.
#  ------------------------
#  This code is licensed by William Woodruff under the MIT License.
#  http://opensource.org/licenses/MIT

require_relative 'yossarian_plugin'

class Decisions < YossarianPlugin
	include Cinch::Plugin
	use_blacklist

	def usage
		'!decide <x or y || z> - Decide between choices. Delimiters are \'or\' and \'||\'.'
	end

	def match?(cmd)
		cmd =~ /^(!)?decide$/
	end

	match /decide (.+)/, method: :decide, strip_colors: true

	def decide(m, query)
		choices = query.split(/ or|\|\| /).map(&:strip).map(&:downcase).uniq
		if choices.size < 2
			m.reply "I need more than one option to choose from.", true
		else
			m.reply choices.sample, true
		end
	end
end
