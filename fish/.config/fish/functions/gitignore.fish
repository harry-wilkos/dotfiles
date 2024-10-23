function gitignore
    set gitignore_file .gitignore

    if test -f $gitignore_file
        echo "$gitignore_file already exists."
        return
    end

    echo "__pycache__/
*.pyc
*.pyo
tmp/
.env
env/
venv/
.ipynb_checkpoints/
.pytest_cache/
*.log
build/
dist/
.idea/
.vscode/
*.sublime-workspace
.DS_Store
Thumbs.db
.coverage
htmlcov/" >$gitignore_file

    echo "$gitignore_file created successfully."
end
