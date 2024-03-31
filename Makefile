push:
	npm run build && git add . && git commit -m 'updates' && git push
deploy:
	sudo rm -rf /var/www/images && sudo cp -r /home/ubuntu/images/dist /var/www/images
