function syncobs --description "Add, commit, and push changes of obsidian vault to gitlab repository"
    set dir "$HOME/Documents/Obsidian Vault/"
    cd $dir

    # Add changes
    git add .
    if test $status -ne 0
        echo "Error: Failed to add changes"
        return 1
    end

    # Commit changes
    git commit -m "update vault"
    if test $status -ne 0
        echo "Error: Failed to commit changes"
        return 1
    end

    # Push changes
    git push
    if test $status -ne 0
        echo "Error: Failed to push changes"
        return 1
    end

    echo "Obsidian changes added, committed, and pushed successfully."
end

