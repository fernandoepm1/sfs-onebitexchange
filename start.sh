# Checa se todas as gems estão instaladas, caso não, roda o bundle
bundle check || bundle install

# Roda nosso servidor
bundle exec puma -C config/puma.rb
