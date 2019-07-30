import MainView from '../main';
import injectGapiScript from '../../page/google-map';

export default class View extends MainView {
  mount() {
    window.initMap = function() {
      const mapOptions = {
        zoom: 15,
        scrollwheel: false,
        center: new google.maps.LatLng(-24.713260, -53.740900)
      };

      const map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);

      const marker = new google.maps.Marker({
        position: map.getCenter(),
        icon: 'https://ik.imagekit.io/ricardoruwer/lchiert/images/map-marker.png',
        map: map
      });

      const styles = [
        {
          'featureType': 'administrative',
          'elementType': 'labels.text.fill',
          'stylers': [
            { 'color': '#8d8d8d' }
          ]
        },
        {
          'featureType': 'landscape',
          'elementType': 'all',
          'stylers': [
            { 'color': '#f5f5f5' }
          ]
        },
        {
          'featureType': 'poi',
          'elementType': 'all',
          'stylers': [
            { 'visibility': 'off' }
          ]
        },
        {
          'featureType': 'poi',
          'elementType': 'labels.text',
          'stylers': [
            { 'visibility': 'off' }
          ]
        },
        {
          'featureType': 'road',
          'elementType': 'all',
          'stylers': [
            { 'saturation': -100 },
            { 'lightness': 45 }
          ]
        },
        {
          'featureType': 'road.highway',
          'elementType': 'all',
          'stylers': [
            { 'visibility': 'simplified' }
          ]
        },
        {
          'featureType': 'road.arterial',
          'elementType': 'labels.icon',
          'stylers': [
            { 'visibility': 'off' }
          ]
        },
        {
          'featureType': 'transit',
          'elementType': 'all',
          'stylers': [
            { 'visibility': 'off' }
          ]
        },
        {
          'featureType': 'water',
          'elementType': 'all',
          'stylers': [
            { 'color': '#dbdbdb' },
            { 'visibility': 'on' }
          ]
        }
      ];
      map.setOptions({styles: styles});
    };

    !window.google && injectGapiScript();

    super.mount();
  }

  unmount() {
    super.unmount();
  }
}
