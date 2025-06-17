module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', [
      'init', 'feat', 'fix', 'docs', 'style',
      'refactor', 'test', 'chore', 'design',
      'comment', 'rename', 'remove', 'breaking-change', 'hotfix'
    ]]
  }
};
