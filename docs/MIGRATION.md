# Migration Guide: Adding Packages to `flutter_wx`

This guide explains how to migrate existing standalone repositories (`wx_box`, `wx_button`, `wx_avatar`, `wx_sheet`, etc.) into the `flutter_wx` monorepo while preserving **100% of their Git commit history and author attribution**.

---

## 🏗️ 1. Migration Strategy: Git Subtree

To merge a standalone repository into `packages/<package_name>` without losing commit history or tags, use `git subtree`.

### Step-by-Step Subtree Ingestion

From the root of `flutter_wx`:

```bash
# Example: Migrating wx_button into packages/wx_button

# 1. Add the remote for the standalone repository
git remote add origin-wx-button https://github.com/davigmacode/wx_button.git

# 2. Fetch all commits and branches
git fetch origin-wx-button

# 3. Add the repository as a subtree into packages/wx_button
git subtree add --prefix=packages/wx_button origin-wx-button main

# 4. Remove the temporary remote
git remote remove origin-wx-button
```

> [!TIP]
> The commit history of `wx_button` is now integrated into `flutter_wx`. Running `git log -- packages/wx_button` will display all historical commits from the original repository.

---

## ⚙️ 2. Package Configuration Checklist

After adding the subtree:

### A. Update `pubspec.yaml`
1. Set the environment constraints:
   ```yaml
   environment:
     sdk: '>=3.5.0 <4.0.0'
     flutter: '>=3.24.0'
   ```
2. Add workspace resolution:
   ```yaml
   resolution: workspace
   ```
3. Update repository and issue links:
   ```yaml
   homepage: https://github.com/davigmacode/flutter_wx
   repository: https://github.com/davigmacode/flutter_wx/tree/main/packages/<package_name>
   issue_tracker: https://github.com/davigmacode/flutter_wx/issues
   ```

### B. Register in Root `pubspec.yaml`
Add the new package path to the root `pubspec.yaml` workspace list:
```yaml
workspace:
  - packages/wx_text
  - packages/wx_text_spoiler
  - packages/wx_text_animated
  - packages/wx_button # <--- New package
  - example
```

### C. Analysis & Linter
In `packages/<package_name>/analysis_options.yaml`, inherit from the root linter config:
```yaml
include: ../../analysis_options.yaml
```

### D. Publish Ignore
Create `packages/<package_name>/.pubignore`:
```text
build/
.dart_tool/
.fvm/
coverage/
```

### E. Pub.dev Example
Ensure `packages/<package_name>/example/main.dart` exists with a concise, self-contained usage demonstration for the pub.dev Example tab.

---

## 🧪 3. Definition of Done (Quality Gates)

Before committing and publishing:

1. **Static Analysis (0 Issues)**:
   ```bash
   dart run melos run analyze
   ```
2. **Automated Tests (100% Passing)**:
   ```bash
   dart run melos run test
   ```
3. **Publish Validation (0 Warnings)**:
   ```bash
   cd packages/<package_name>
   dart pub publish --dry-run
   ```
4. **Clean Git State**:
   Commit with conventional commits (e.g. `feat: add wx_button package to monorepo`).
