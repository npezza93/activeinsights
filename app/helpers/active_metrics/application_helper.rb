module ActiveMetrics
  module ApplicationHelper
    def active_metrics_importmap_tags(entry_point = "application", shim: true)
      importmap = ActiveMetrics::Engine.configuration.importmap

      safe_join [
        javascript_inline_importmap_tag(importmap.to_json(resolver: self)),
        javascript_importmap_module_preload_tags(importmap),
        javascript_import_module_tag(entry_point)
      ], "\n"
    end
  end
end
