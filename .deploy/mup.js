module.exports = {
  servers: {
    one: {
      host: '52.28.7.104',
      username: 'ubuntu',
      pem: '/Users/user/Dropbox/keys/aws/ahsl.pem'
      // password:
      // or leave blank for authenticate from ssh-agent
    }
  },

  meteor: {
    name: 'ahsl',
    path: '../../ahsl',
    servers: {
      one: {}
    },
    //buildOptions: {
    //  serverOnly: true
    //},
    env: {
      ROOT_URL: 'http://ec2-52-28-7-104.eu-central-1.compute.amazonaws.com',
      MONGO_URL: 'mongodb://localhost:27017/ahsl_db'
    },

    //dockerImage: 'kadirahq/meteord'
    deployCheckWaitTime: 60
  },

  mongo: {
    oplog: false,
    port: 27017,
    servers: {
      one: {},
    },
  },
};