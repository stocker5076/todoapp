namespace :clean do
	desc 'Runs rake assests:clobber en el server para remover los asset compilados'
	task :assests do
		on roles(:app) do
			whithin "#{current_path}" do
				whith rails_env :production do
					excecute :rake, 'assests:clobber'
					excecute :touch, release_path.join('tmp/restart.txt')
				end
			end	
		end
	end	
end