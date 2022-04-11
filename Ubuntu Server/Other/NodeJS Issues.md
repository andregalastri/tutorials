# NODEJS ISSUES

## Dependency errors with `npx create-react-app`:

> I was having an error like this:
> 
> ```
> While resolving: tscurso@0.1.0
> Found: react@18.0.0
> node_modules/react
>   react@"^18.0.0" from the root project
> 
> Could not resolve dependency:
> peer react@"<18.0.0" from @testing-library/react@12.1.5
> node_modules/@testing-library/react
>   @testing-library/react@"^12.0.0" from the root project
> 
> Fix the upstream dependency conflict, or retry
> this command with --force, or --legacy-peer-deps
> to accept an incorrect (and potentially broken) dependency resolution.
> ```
#### Resolution

Use the `--legacy-peer-deps` before calling `create-react-app`

```bash
npx --legacy-peer-deps create-react-app my-project
```
<br>

## Using React with Typescript:

> The `--typescript` option seems to not work.
#### Resolution

Use the `--template typescript` after the project name/folder.

```bash
npx create-react-app my-project --template typescript
```
<br>
