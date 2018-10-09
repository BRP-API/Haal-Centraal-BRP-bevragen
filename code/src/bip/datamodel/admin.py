from django.contrib import admin

from .models import IngeschrevenNatuurlijkPersoon


@admin.register(IngeschrevenNatuurlijkPersoon)
class NatuurlijkPersoonAdmin(admin.ModelAdmin):
    pass
