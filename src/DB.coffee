> rxdb > createRxDatabase
  rxdb/plugins/storage-dexie > getRxStorageDexie


# > rxdb > addRxPlugin
#   rxdb/plugins/dev-mode > RxDBDevModePlugin
#
# addRxPlugin(RxDBDevModePlugin)

export default DB = await createRxDatabase({
  name: 'testdb'
  storage: getRxStorageDexie()
  eventReduce: true
})

schema = {
  title: 'human schema'
  version: 0
  primaryKey: 'passportId'
  type: 'object'
  properties: {
      passportId: {
          type: 'string'
          maxLength: 100 # <- the primary key must have set maxLength
      }
      firstName: {
          type: 'string'
      }
      lastName: {
          type: 'string'
      }
      age: {
          description: 'age in years'
          type: 'integer'
          # number fields that are used in an index must have set minimum maximum and multipleOf
          minimum: 0
          maximum: 150
          multipleOf: 1
      }
  }
  indexes: ['age']
  required: ['firstName','lastName','passportId']
}

collection = await DB.addCollections({
  humans:
    schema: schema
})

doc = await DB.humans.insert({
    passportId: 'foobar'
    firstName: 'Alice'
    lastName: 'Carol'
    age: 42
})

doc.lastName$.subscribe (lastName) =>
  console.log('lastName is now ' + lastName)
  return

li = await DB.humans.find({
    selector: {
        age: {
            $gt: 21
        }
    }
}).exec()

DB.humans.find({
  selector:
    age:
      $gt: 21
}).$.subscribe (li) =>
  console.log(
    'query has found ' + li.length + ' documents'
  )
  return

await doc.incrementalModify (data) =>
  data.lastName = 'Carol'
  data

await doc.incrementalPatch({
  lastName: 'Carol incrementalPatch'
})

# await doc.remove()

