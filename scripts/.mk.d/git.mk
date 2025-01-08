.PHONY: git.setup \
		git.up    \
		up

git.setup:
	git init 												                                              && \
	git config --global user.email "$(USER_EMAIL)" 			                                              && \
	git config --global user.name "$(USER_NAME)" 			                                              && \
	git config --global --add safe.directory $(CONTAINER_PATH)                                            && \
	git config --global credential.helper store 			                                              && \
	git remote add origin https://$(USER_NAME):$(GITHUB_TOKEN)@github.com/$(USER_NAME)/$(GITHUB_REPO).git && \
	git branch -m main

git.up:
	git add . && git commit --allow-empty-message -m "" && git push -u origin main

git.up.force:
	git add . && git commit --allow-empty-message -m "" && git push -u origin main --force

up: git.up
