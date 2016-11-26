camera = null
scene = null
renderer = null

window.init = () ->
  camera = new THREE.PerspectiveCamera( 40, window.innerWidth / window.innerHeight, 1, 10000 )
  camera.position.z = 3000

  scene = new THREE.Scene()

  renderer = new THREE.CSS3DRenderer()
  renderer.setSize( window.innerWidth, window.innerHeight )
  renderer.domElement.style.position = 'absolute'
  document.getElementById( 'container' ).appendChild( renderer.domElement )

  object = new THREE.CSS3DObject( $('#home_button')[ 0 ] )
  object.position.x = -425
  object.position.y = 270
  object.position.z = 1700

  scene.add( object )

  $('#home_button')[0].parent = object;
  $('#home_button').click( () ->
    obj = $( this )[0].parent

    targetX = Math.PI * 2

    if obj.rotation.x == targetX
      targetX = 0

    new TWEEN.Tween( obj.rotation )
    .to( {x: targetX}, 1000)
    .easing( TWEEN.Easing.Linear.None )
    .start();

    new TWEEN.Tween( this )
    .to( {}, 1000 )
    .onUpdate( render )
    .start();
  )

  object2 = new THREE.CSS3DObject( $('#contact_button')[ 0 ] )
  object2.position.x = -425
  object2.position.y = 220
  object2.position.z = 1700

  scene.add( object2 )

  object3 = new THREE.CSS3DObject( $('#contents')[ 0 ] )
  object3.position.x = 70
  object3.position.y = 0
  object3.position.z = 1660

  scene.add( object3 )

  window.addEventListener( 'resize', onWindowResize, false )

  render()

window.onWindowResize = () ->
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()

  renderer.setSize( window.innerWidth, window.innerHeight )

  render()

window.animate = () ->
  requestAnimationFrame( animate )
  TWEEN.update()

window.render = () ->
  renderer.render( scene, camera )

$(document).ready ->
  init()
  animate()
