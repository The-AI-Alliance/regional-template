# How to Use `regional-template`

This repo is used as a template to create AI Alliance &ldquo;microsites&rdquo; for regional chapters. It is setup as a GitHub _template repo_, which you can use to create a new repo. Even if you aren't creating a microsite, you can use this procedure to create a new AI Alliance repo for other purposes. 

> [!WARN]
> The contents of the `docs` folder here, which contains the website pages, follows our conventional `microsite-template` format, based on _Just the Docs_. We use a different format for the regional sites. Unfortunately, you will have to make these changes manually until we update them. See the [Japan site repo](https://github.com/The-AI-Alliance/japan) for an example of the current chapter website format. 

## Creating Your Repo

These are the main steps, with details below:

1. Create your repo from the [the `regional-template` repo](https://github.com/The-AI-Alliance/regional-template).
1. Convert placeholder _variables_ to the correct values, using the [`finish-microsite.sh`](https://github.com/The-AI-Alliance/regional-template/blob/main/finish-microsite.sh) script.
1. Add your initial content for the repo, mostly in `docs`, but also the top-level `README.md`.
1. Commit changes to the `main` branch.
1. Push all updates upstream, `git push --all`.
1. On the repo's home page in GitHub, click the "gear" next to "About" (upper right-hand side). In the _Edit repository details_ that pops up, check the box to _Use your GitHub Pages website_ and enter appropriate _Topics_.
1. Add the website to the Alliance GitHub organization [landing page](https://github.com/The-AI-Alliance/), the Alliance GitHub Pages [website](https://the-ai-alliance.github.io/#the-ai-alliance-projects), and the [main Alliance site](https://thealliance.ai). 
1. When finished, delete this file!

> [!NOTE] 
> We are planning to automate as many of the manual steps as we can.

Let's look at these steps in more detail.

### 1. Create your repo from the `regional-template`.

Pick a name for your new repo and follow [these GitHub instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) to create a new repo from the [`regional-template`](https://github.com/The-AI-Alliance/regional-template) repo.

### 2. Convert the placeholder _variables_.

After step 1., your repo will have placeholder values for the project name, etc. Next, change to the repo root directory and run the script [`finish-microsite.sh`](https://github.com/The-AI-Alliance/regional-template/blob/main/finish-microsite.sh) to replace the placeholder _variables_ with appropriate strings for your project.

> [!WARN]
> The `finish-microsite.sh` script uses `zsh`. If you don't have `zsh` available, then use `bash` version 5 or later, e.g., `bash finish-microsite.sh ...`.

Run `finish-microsite.sh --help` to see the required arguments. At the time of this writing, you only need to specify the name of the regional chapter. Here is an example for the USA::

```shell
./finish-microsite.sh United States of America
```

> [!WARN]
> At the end of the script's execution, it will push the changes upstream to the GitHub repo.

### 3. Add your initial content for the repo.

There are other placeholder texts in the `docs/**/*.markdown`, README, and other files that you should replace with your real content as soon as possible, e.g.,

1. Find and replace all occurrences of `TODO` with appropriate content.
1. Rename or delete the `second_page.markdown`. Copy it to add more top-level pages, but change the `nav_order` field to control the order of the pages shown in the left-hand side navigation view. 
1. Rename or delete the `nested` directory and its pages, which demonstrates how to use nested content for a hierarchical site organization.

> [!TIP]
> Start with `10`, `20`, etc. for the `nav_order` of top-level pages, giving yourself room to insert new pages in between existing pages. For nested pages, e.g., under `20`, use `210`, `220`, etc.

3. See the `nested` directory content as an example of how to do nesting, or delete it if you don't need it. Note the metadata fields at the top, such as the `parent` and `has_children` fields.
4. Make any changes you want to make in the `docs/_config.yml` file. (None are mandatory.)

For more tips and guidance on development tasks, see also the links for more information in the `README.md` in your new repo. Add a project-specific description at the beginning of that file.

### 4. Commit changes to the `main` branch.

You are already working in the `main` branch of your local copy of the repo. Now commit those changes:

```shell
git commit --message "First edits" .
```

The "dot" (`.`) effectively. means "everything in the current directory and all subdirectories". You can use `-m` as a shorthand alternative to `--message`. The message shown in quotes can be anything you want, but a message is required.

### 5. Push all updates upstream.

Run the following command to push everything "upstream" to GitHub:

```shell
git push --all
```

Adding `--all` isn't really necessary, but in some cases it is "helpful".

### 6. Add Your website to the Alliance GitHub Pages and the Alliance Website.

When you are ready for broader exposure for the site, there are a few places where we have an index to all the &ldquo;microsites&rdquo;. Find the location where chapter sites are listed and add it there.

* https://github.com/The-AI-Alliance/.github/blob/main/profile/README.md
* https://github.com/The-AI-Alliance/the-ai-alliance.github.io/blob/main/docs/index.markdown

You can just edit the page directly in GitHub and submit a PR. Note that for the second link, the `index.markdown` page for the `the-ai-alliance.github.io` site.

Finally, talk to our website maintainers about adding the new site to the [AI Alliance website](https://thealliance.ai).

### 7. When finished, delete this file

This file is no longer needed, so you can remove it from your repo and push this change upstream:

```shell
git rm README-template.md
git ci -m "Removed the README-template.md, which is no longer needed"
git push
```
