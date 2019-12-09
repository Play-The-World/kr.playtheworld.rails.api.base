# PlayTheWorld API

## Instruction

1. Create Rails App

```bash
rails new PlayTheWorldAPI -T -C -B --skip-active-record --api
```

2. Disabled action_mailer and active_model

3. Added middlewares [rack-attack](https://github.com/kickstarter/rack-attack) and [rack-cors](https://github.com/cyu/rack-cors)

4. Added [config](https://github.com/railsconfig/config) gem