namespace :setup do

	desc "Upload database.yml fle."
	task :database do
		on roles(:app) do
			execute "mkdir -p #{shared_path}/config"
			upload! StringIO.new(File.read("config/database.yml")),"#{shared_path}/config/database.yml"
		end
	end
	
	desc "Upload secrets.yml fle."
	task :secrets do
		on roles(:app) do
			execute "mkdir -p #{shared_path}/config"
			upload! StringIO.new(File.read("config/secrets.yml")),"#{shared_path}/config/secrets.yml"
		end
	end
	

	desc "Upload .env fle."
	task :env do
		on roles(:app) do
			execute "mkdir -p #{shared_path}"
			upload! StringIO.new(File.read(".env")),"#{shared_path}/.env"
		end
	end

	desc "Seed the database"
	task :seed do
		on roles(:app) do
			whithin "#{current_path}" do
				whith rails_env :production do
					execute :rake, "db:seed"
				end	
			end
		end
	end

end
