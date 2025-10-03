String removeRutFormatting(String rut) {
  return rut.replaceAll(RegExp(r'[\.\-\s]'), '');
}
