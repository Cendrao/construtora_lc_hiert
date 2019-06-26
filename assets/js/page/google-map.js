export default function injectGapiScript() {
  const script = document.createElement('script');
  const body = document.getElementsByTagName('body')[0];

  script.type = 'text/javascript';
  script.async = true;
  script.defer = true;
  script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyCeeHDCOXmUMja1CFg96RbtyKgx381yoBU&callback=initMap';

  body.appendChild(script);
}
