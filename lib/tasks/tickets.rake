namespace :tickets do
  desc 'Import tickets from CSV file'
  task :import => :environment do
    result = Tickets::ImportFromCsv.execute

    puts "Successfully imported #{result.count} #{'ticket'.pluralize(result.count)}"
  rescue Errno::ENOENT
    puts 'CSV storage is empty. Try to submit some tickets first.'
  end
end
