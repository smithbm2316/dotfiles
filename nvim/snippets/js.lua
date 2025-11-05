return {
  {
    body = "import { $1 } from '$0';",
    desc = 'import',
    prefix = 'imp',
  },
  {
    body = "import $1 from '$0';",
    desc = 'import default',
    prefix = 'imd',
  },
  {
    body = 'console.error($0);',
    desc = 'console.error',
    prefix = 'error',
  },
  {
    body = 'console.warn($0);',
    desc = 'console.warn',
    prefix = 'warn',
  },
  {
    body = 'console.log($0);',
    desc = 'console.log',
    prefix = 'log',
  },
  {
    body = 'console.debug($0);',
    desc = 'console.debug',
    prefix = 'logd',
  },
  {
    body = 'console.dir($0, { depth: Infinity });',
    desc = 'console.dir infinity',
    prefix = 'loginf',
  },
  {
    body = 'console.debug(JSON.stringify({ $0 }, null, 2));',
    desc = 'console.debug JSON stringified',
    prefix = 'logdj',
  },
  {
    body = '// @ts-expect-error $0',
    desc = '@ts-expect-error',
    prefix = 'tse',
  },
  {
    body = '// eslint-disable-next-line $0',
    desc = 'eslint-disable-next-line',
    prefix = 'esdl',
  },
  {
    body = '// eslint-disable-next-line eslint-comments/disable-enable-pair\n/* eslint-disable $0 */',
    desc = 'eslint-disable-file',
    prefix = 'esdf',
  },
  {
    body = '/* eslint-disable $1 */\n$0\n/* eslint-enable $1 */',
    desc = 'eslint-disable-block',
    prefix = 'esdb',
  },
  {
    body = "import { selectors } from './selectors';",
    desc = 'selectors',
    prefix = 'select',
  },
  {
    body = '/** $1 */',
    desc = 'js-docstring-line',
    prefix = 'jsdl',
  },
  {
    body = '/**\n * $1\n */',
    desc = 'js-docstring-multiline',
    prefix = 'jsdm',
  },
}
