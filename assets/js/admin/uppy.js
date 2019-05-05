// Import Plugins
const Uppy = require('@uppy/core')
const XHRUpload = require('@uppy/xhr-upload')
const Dashboard = require('@uppy/dashboard')

// Import Styles
require('@uppy/core/dist/style.css')
require('@uppy/dashboard/dist/style.css')

// Set Options
const translations = {
  addingMoreFiles: 'Adicionando mais fotos',
  addMoreFiles: 'Adicionar mais fotos',
  back: 'Voltar',
  browse: 'selecione',
  cancel: 'Cancelar',
  complete: 'Terminou',
  dropHint: 'Solte suas fotos aqui',
  dropPaste: 'Arraste, cole ou %{browse} as fotos',
  exceedsSize: 'Essa foto excede o tamanho máximo de',
  failedToUpload: 'Falha no envio de %{file}',
  removeFile: 'Remover foto',
  retry: 'Tentar novamente',
  retryUpload: 'Enviar novamente',
  uploadComplete: 'Fotos enviadas',
  uploadFailed: 'Falha no envio',
  uploading: 'Enviando',
  uploadXFiles: {
    '0': 'Enviar %{smart_count} foto',
    '1': 'Enviar %{smart_count} fotos',
    '2': 'Enviar %{smart_count} fotos'
  },
  uploadXNewFiles: {
    '0': 'Enviar +%{smart_count} foto',
    '1': 'Enviar +%{smart_count} fotos',
    '2': 'Enviar +%{smart_count} fotos'
  },
  uploadingXFiles: {
    '0': 'Enviando %{smart_count} foto',
    '1': 'Enviando %{smart_count} fotos',
    '2': 'Enviando %{smart_count} fotos'
  },
  xFilesSelected: {
    '0': '%{smart_count} foto selecionada',
    '1': '%{smart_count} fotos selecionadas',
    '2': '%{smart_count} fotos selecionadas'
  }
}

const uppyOpts = {
  restrictions: {
    maxFileSize: 2000000, // in bytes
    allowedFileTypes: ['image/*']
  }
}

const dashboardOpts = {
  inline: true,
  target: '#select-files',
  width: '100%',
  height: 390,
  locale: { strings: translations }
}

// Get Data
const endpoint = $('#select-files').data('endpoint')
const csrfToken = $("meta[name='csrf-token']").attr('content')

// Start Uppy!
const uppy = Uppy(uppyOpts)
  .use(Dashboard, dashboardOpts)
  .use(XHRUpload, { endpoint: endpoint, fieldName: 'image' })

uppy.setMeta({ _csrf_token: csrfToken })
