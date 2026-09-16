# Running Both Projects

This workspace contains two independent Spring Boot projects:

- `J2-week02`: current project, runs on `http://localhost:8090`
- `demo03-2024`: imported demo03 project, backend runs on `http://localhost:8070`

Run each app in a separate terminal:

```powershell
.\scripts\run-j2-week02.ps1
```

```powershell
.\scripts\run-demo03-backend.ps1
```

The demo03 frontend is in `demo03-2024/front` and runs on `http://localhost:5173`:

```powershell
.\scripts\run-demo03-front.ps1
```

Useful URLs:

- Current project todos: `http://localhost:8090/todos`
- demo03 backend: `http://localhost:8070`
- demo03 Swagger UI: `http://localhost:8070/swagger-ui/index.html`
- demo03 frontend: `http://localhost:5173`

Notes:

- The demo03 `dev` and `test` profiles include dummy JWT secrets for local study use.
- The two backend ports are already different, so both can run at the same time.
