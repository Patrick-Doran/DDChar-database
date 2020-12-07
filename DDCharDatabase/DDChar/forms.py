from django import forms
from .models import *

class spellForm(forms.ModelForm):
    
    class Meta:
        model = Spell
        fields = ['sp_name', 'sp_slotlevel', 'sp_range', 'sp_castingtype', 'sp_effect', 'sp_die']
