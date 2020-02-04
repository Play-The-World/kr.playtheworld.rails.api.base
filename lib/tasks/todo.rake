desc "Todo list"
task todo: :environment do
  exec("rails notes --annotations TODO")
end