desc "Rails Credentials"
task cre: :environment do
  exec("EDITOR='code --wait' rails credentials:edit")
end