env = ENV["RACK_ENV"] || "development"

if ENV["DATABASE_URL"]
	DataMapper.setup(:default, ENV["DATABASE_URL"])
else 
	DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
end

DataMapper.finalize

DataMapper.auto_upgrade!
