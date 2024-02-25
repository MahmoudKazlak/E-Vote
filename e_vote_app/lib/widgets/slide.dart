class Slide{
   String imageurl;
   String title;
   String description;

  Slide({
    required this.imageurl,
    required this.title,
    required this.description});
}
 var slideList =[
  Slide(
    imageurl: "assets/images/talking.jpg",
    title: 'This is our title',
    description: 'some description',
  ),
  Slide(
    imageurl: "assets/images/singing.jpg",
    title: 'This is our title',
    description: 'some description',
  ),
  Slide(
    imageurl: "assets/images/event.jpg",
    title: 'This is our title',
    description: 'some description',
  ),
 ];
