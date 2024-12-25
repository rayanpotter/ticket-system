docker exec -it laravel-ticket-system-db bash #to access to the db container

mysql -u zimou -p # to access to the database

zimou123   #password

docker exec -it laravel-ticket-system-app bash #to access to the app env

cd /var/www/html/my-laravel-app   #to enter the laravel env

php artisan migrate      #to push the migration

docker-compose up --build      #to build and run the app