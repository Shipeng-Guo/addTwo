# R 包开发规则清单（模板）

## 项目骨架
- 必备文件/目录：`R/`、`DESCRIPTION`、`NAMESPACE`、`README.md`、`LICENSE`、`.Rbuildignore`、`.gitignore`
- `.Rbuildignore` 排除：`.git`、`.gitignore`、`README.md`、`LICENSE`、本地配置等

## 代码与文档
- 函数置于 `R/*.R`，采用 roxygen2 注释
- 示例简短可运行；需导出的函数标注 `@export`

## DESCRIPTION 关键规则
- `Authors@R` 必须含维护者（`cre` 角色），姓名非空、邮箱有效
- 多行字段的续行需空格缩进；右括号所在行也需要缩进
- 最小字段：`Package`、`Type`、`Title`、`Version`、`Description`、`License`、`Encoding`、`Authors@R`
- 推荐字段：`Roxygen: list(markdown = TRUE)`、`RoxygenNote`、`Depends: R (>= 3.5.0)`、`URL`、`BugReports`

示例（通过 R CMD 检查）：

```r
Authors@R: c(
    person(given = "Shipeng", family = "Guo", role = c("aut", "cre"),
           email = "shipeng@users.noreply.github.com", comment = c(ORCID = "")) 
 )
```

## NAMESPACE 导出
- 确保导出所有对外函数（`@export` 或手工 `export(func)`）

## 构建与检查
- 本地先执行：`R CMD build .` 与 `R CMD check <tar.gz>`
- 常见错误：`DESCRIPTION meta-information`（多因 Authors@R/缩进/邮箱）

## Git/GitHub 推送
- 首次提交配置 `user.name` 与 `user.email`
- 推荐 SSH：生成 ed25519 密钥并添加到 GitHub，远程使用 `git@github.com:<user>/<repo>.git`
- 若用 HTTPS，需使用 PAT（GitHub 不再接受密码）；可用 `gitcreds::gitcreds_set()` 管理
- 统一默认分支为 `main`

## 安装与鉴权（remotes）
- 公共仓库安装无需令牌；避免 401 办法：
  - 临时：`Sys.unsetenv("GITHUB_PAT"); remotes::install_github("user/repo", auth_token = NULL)`
  - 永久：移除/更新 `.Renviron` 中的 `GITHUB_PAT`
- 401/Bad credentials 多因过期或错误 PAT

## WSL2/网络/SSH 注意
- 首次 SSH 可用 `-o StrictHostKeyChecking=accept-new`
- 推送卡顿多因鉴权或网络；确认密钥已添加并重试

## 诊断命令
- `git status -sb`
- `git log --oneline -n 3`
- `git remote -v`
- `git ls-remote --heads origin`
- `env GIT_SSH_COMMAND="ssh -v -o StrictHostKeyChecking=accept-new" git push -u origin main`

## 最小 DESCRIPTION 示例

```r
Package: <pkgname>
Type: Package
Title: <One line title>
Version: 0.1.0
Authors@R: c(
    person(given = "<Given>", family = "<Family>", role = c("aut", "cre"),
           email = "<email>") 
 )
Description: <Short description.>
License: MIT + file LICENSE
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.3.2
Depends: R (>= 3.5.0)
URL: https://github.com/<user>/<repo>
BugReports: https://github.com/<user>/<repo>/issues
```

> 本规则文件来自实际踩坑总结，可直接复制到新包作为检查清单。

