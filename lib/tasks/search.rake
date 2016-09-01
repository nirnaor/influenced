require 'video_provider'
require 'influences_provider'

namespace :search do
  task :video, [:query] do |t, args|
    puts VideoProvider.new.search args[:query]
  end

  task :influences, [:query] do |t, args|
    q = args[:query]
    puts "Influences for #{q}"
    puts InfluencesProvider.new.search q
  end

end
