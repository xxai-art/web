#!/usr/bin/env coffee

> ./s3.cdn:
  ./env > PUBLIC SRC
  dotenv
  path > join basename
  @w5/walk:@ > walkRel
  fs > createReadStream readdirSync readFileSync existsSync
  radix-64:Radia64
  @w5/blake3 > Blake3
  @w5/zipint > zip
  @w5/read
  @w5/write
  @w5/ossput:put

{encodeInt,decodeToInt} = Radia64()

i18n_dir = join(PUBLIC,'i18n')

upload = (ver, file_li)=>
  for i from file_li
    fp = join(i18n_dir, i)
    await put(
      'I18N/'+ver+'/'+i
      =>
        createReadStream fp
      'text/css'
    )
  return

js_dir = join SRC,'i18n'

var_js = join(js_dir,'var.js')
{ver,posId} = await import(var_js)
hasher = new Blake3
hasher.update zip posId

file_li = []
for await i from walkRel i18n_dir
  if basename(i).startsWith('.')
    continue
  hasher.update readFileSync(join(i18n_dir,i))
  file_li.push i

hash_fp = join(js_dir,'.hash')
hash = Buffer.from(hasher.finalize()).toString('base64')

+ do_write

if existsSync hash_fp
  if hash != read(hash_fp).trim()
    do_write = 1
    ver = encodeInt(decodeToInt(ver)+1)
else
  do_write = 1

if do_write
  await upload ver, file_li
  write(
    hash_fp
    hash
  )
  write(
    var_js
    """\
    export const ver = '#{ver}' // #{decodeToInt ver}
    export const posId = #{JSON.stringify(posId)}
    """
  )

console.log 'ver', decodeToInt(ver)
