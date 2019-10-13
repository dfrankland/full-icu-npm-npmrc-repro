const { spawn } = require('child_process');
const { resolve } = require('path');

const child = spawn(
  'npm',
  ['login', '--registry=' + process.env.REGISTRY, '--always-auth'],
  {
    cwd: __dirname,
    env: Object.assign(
      {},
      process.env,
      { NPM_CONFIG_USERCONFIG: resolve(__dirname, '.npmrc') },
    ),
  },
);

child.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});

child.stderr.on('data', (data) => {
  console.log(`stderr: ${data}`);
});

setTimeout(() => child.stdin.write('username\n'), 1000);
setTimeout(() => child.stdin.write('password\n'), 1500);
setTimeout(() => child.stdin.write('username@test.com\n'), 2000);
