resource "github_repository" "example1" {
  name        = "example"
  description = "My awesome codebase"

  private = true

  template {
    owner = "github"
    repository = "terraform-module-template"
  }
}

resource "github_repository" "example2" {
  name        = "example"
  description = "My awesome codebase"

  visibility = "private"

  template {
    owner = "github"
    repository = "terraform-module-template"
  }
}

resource "github_repository" "example3" {
  name        = "example"
  description = "My awesome codebase"

  private = true
  visibility = "private"

  template {
    owner = "github"
    repository = "terraform-module-template"
  }
}
