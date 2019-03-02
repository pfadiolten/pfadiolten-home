import Hammer from 'hammerjs';

$(() => {
  $('.carousel').each((_, carousel) => {
    const $carousel: any = $(carousel);
    new Hammer(carousel).on('swipeleft', () => {
      $carousel.carousel('next');
    });
    new Hammer(carousel).on('swiperight', () => {
      $carousel.carousel('prev');
    });
  });
});