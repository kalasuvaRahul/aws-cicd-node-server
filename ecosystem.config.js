module.exports = {
  apps: [
    {
      name: "aws-cicd-node-server",
      script: "dist/index.js",
      instances: 1,
      exec_mode: "fork",
      autorestart: true,
      watch: false,
      max_memory_restart: "300M",
      min_uptime: "10s",
      max_restarts: 10,
      restart_delay: 5000,
      exp_backoff_restart_delay: 100,
      out_file: "./logs/out.log",
      error_file: "./logs/error.log",
      merge_logs: true,
      time: true,
      env: {
        NODE_ENV: "development",
        PORT: 3000,
      },
      env_production: {
        NODE_ENV: "production",
        PORT: 3000,
      },
    },
  ],
};
